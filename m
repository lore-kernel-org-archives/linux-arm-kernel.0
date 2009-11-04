From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 4 Nov 2009 20:27:29 +0200
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
In-Reply-To: <200910290949.28010.anarsoul@gmail.com>
References: <200910201719.41102.anarsoul@gmail.com>
	<2accc2ff0910232359t1bc7515avb7b208ffbd112807@mail.gmail.com>
	<200910290949.28010.anarsoul@gmail.com>
Message-ID: <200911042027.34278.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 29 ??????? 2009 09:49:20 ????? Vasily Khoruzhick ???????:
> ? ????????? ?? 24 ??????? 2009 09:59:25 ????? Nelson Castillo ???????:
> > >@@ -224,6 +225,7 @@ struct s3c_adc_client *s3c_adc_register(struct
> > > platform_device *pdev,
> > >
> > > 	client->is_ts = is_ts;
> > >
> > > 	client->select_cb = select;
> > >
> > > 	client->convert_cb = conv;
> > >
> > >+	client->selected = 0;
> >
> > You don't need to clear client->selected. kzalloc takes care of this.
> 
> Ok, here's a fixed version.

Any chance to get review/comments on this patch?

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091104/077489aa/attachment.sig>
