From: tomi.valkeinen@gmail.com (Tomi Valkeinen)
Date: Fri, 1 Apr 2016 10:49:13 +0300
Subject: dtc warnings
In-Reply-To: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
Message-ID: <56FE27F9.2070100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 01/04/16 04:40, Rob Herring wrote:
> You may have noticed that linux-next had gotten noisy with dtc
> warnings lately. I dropped the change for a bit, but added it back
> today except now it is disabled unless building with "W=1".
> 
> There's ~25K (2500 unique) warnings generated from the ARM dts files.
> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
> on the similar counts, probably lots of duplicates). Please help
> remind contributors to test with W=1 and start to fix these.
> 
> At least for memory nodes, I plan to whitelist allowing no
> unit-address. There could be others, but none that I've seen so far.

What's the correct way to fix nodes for display platform devices? For
example, omap4-panda-common.dtsi has two connector nodes:

dvi0: connector at 0 {
	compatible = "dvi-connector";
	label = "dvi";
	...
};


hdmi0: connector at 1 {
	compatible = "hdmi-connector";
	label = "hdmi";
	...
};

Should I add the reg property, or should I rename the nodes to, say,
connector_dvi and connector_hdmi, or connector1 and connector2?

The index (reg) is not used for anything, but perhaps there could be
some use for it in the future (although I have no idea what the use
would be).

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160401/3f8f3529/attachment.sig>
