From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 29 Oct 2009 09:49:20 +0200
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
In-Reply-To: <2accc2ff0910232359t1bc7515avb7b208ffbd112807@mail.gmail.com>
References: <200910201719.41102.anarsoul@gmail.com>
	<200910221410.28632.anarsoul@gmail.com>
	<2accc2ff0910232359t1bc7515avb7b208ffbd112807@mail.gmail.com>
Message-ID: <200910290949.28010.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 24 ??????? 2009 09:59:25 ????? Nelson Castillo ???????:
> >@@ -224,6 +225,7 @@ struct s3c_adc_client *s3c_adc_register(struct
> > platform_device *pdev,
> >
> > 	client->is_ts = is_ts;
> >
> > 	client->select_cb = select;
> >
> > 	client->convert_cb = conv;
> >
> >+	client->selected = 0;
> 
> You don't need to clear client->selected. kzalloc takes care of this.

Ok, here's a fixed version.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-s3c24xx-adc-resume-convertions-interrupted-by-going-.patch
Type: text/x-patch
Size: 3397 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091029/d4ae5fc6/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091029/d4ae5fc6/attachment.sig>
