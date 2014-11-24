From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 24 Nov 2014 13:47:49 +0200
Subject: [PATCH v2 1/5] video: omapdss: Add opa362 driver
In-Reply-To: <BF6765C1-8D5C-4ABA-8796-195058C82E17@goldelico.com>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com>
 <1415830247-31633-2-git-send-email-marek@goldelico.com>
 <54649B43.1000801@ti.com>
 <9FD016B8-4EA2-4A0D-B790-6494AB449B31@goldelico.com>
 <5464DF26.2010707@ti.com>
 <BF6765C1-8D5C-4ABA-8796-195058C82E17@goldelico.com>
Message-ID: <54731AE5.7080607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/14 17:10, Dr. H. Nikolaus Schaller wrote:

>> You don't need to ask. The connector calls invert_vid_out_polarity
>> before enabling the output.
> 
> Unfortunately it doesn?t. At least not always.
> 
> It does only for pdata systems but not for DT based systems:
> 
> 	if (!ddata->dev->of_node) {
> 		in->ops.atv->set_type(in, ddata->connector_type);
> 		in->ops.atv->invert_vid_out_polarity(in,
> 			ddata->invert_polarity);
> 	}
> 
> Not calling is in our case different from calling with ddata->invert_polarity == 0.

Ah, sorry, my mistake. I should've read the code more carefully =).

So, with DT only approach, those calls above are not supported. If you
make the OPA driver DT only, you can remove those functions.

You only need to set the invert-polarity property in the venc DT node.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/6701141c/attachment.sig>
