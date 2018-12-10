Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F1CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16DD2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ohoWI/vI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWhjKnSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16DD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3ImXwXPF+fa0LY5MFycK0WkSA/15gQuTr88KzhqHN+8=; b=ohoWI/vIiekstIYs/IRsWsF+X
	qoHnzTuKhKuXXnu3kHdm3C+n7zuZ1/Wp3GRd1Y7J/8XMwOnxp0W1a+HnBoQLuXHwFeDCpYMpylUaD
	/3NuRIOZK0TOYi7GnGLmIg9eYESXCrIl0THititVxFTK7AT8s6gYG2FWUMg/N6S4ICVd1OPNLPWnR
	PJxiA4YwuysLUYLnWQe7qS/ROjjMX5ozVNIkJpVYyiZR0Ga5d/TrBbi43GPw6UgcH1v/nMIVbZYv/
	3rYd33ttwXHp1SoZo+PmtAEWg0x1c29PHN7jtz11587YjbF2/6ZN41zLapUc3o/QrKNpZtDipW9KE
	1dhqv8sgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIKf-0006bk-GG; Mon, 10 Dec 2018 09:58:33 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIKb-0006b2-OR
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:58:31 +0000
Received: by mail-ed1-x544.google.com with SMTP id d39so8898337edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Jle8YreiZ7lhs4SjdDYTvzMCf4EqBhAtQxE9dWMGF5s=;
 b=CWhjKnSgp/8B6kTg02CTbVdeY7XzYJ8YbyalLzCX3qEFF5hL/lKJOzUR+v97LYzQqv
 hXi8dazJRHfHNAZtle7LeJwl2GHclPM2KiC6ee6OxoZ6dZBaxZ8lvPcg0v5H7AUdD+dV
 3NGS+bco6iJ9H4Kb3Q6NdXLrT1c2rEN6F7CMtGM//ev0wfwSyb9ZC7gUPB2qn/YrID0b
 /58n8Se2Puj3B+J/vZCoesoZGmgaDjJCzpzbmGaeqFeuRGV8mVsuRv6YlIhOf0FwPFuj
 SBNBSlkc3E5qQV4GSE4EnIoIKkoOoAkp4yP4nhBBY0eccPy9XX3O9u5F6bBwRojMR07s
 YyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Jle8YreiZ7lhs4SjdDYTvzMCf4EqBhAtQxE9dWMGF5s=;
 b=kMo9OFc7ukjMs3K4VI6FGhc+DYJJvrSL3XCLnu0pRE+EPmW9kUmPvuuo3O/y/oHJCL
 dmtsgn9lNvNXKIz0i3JAzHSj9hc8sl7Zs7Px9QCRrwIBaHT6fNaLbZFGBaXdtzHGGhw4
 /4MRJovVXUIFTAKFMfBJbbnrmuVqhCVgQJVjCGVrqrSr/9isvYrn6e74xrnWtv0zUxZ9
 gWOBNCbskwG9LSkJPml92r0AadQExY7jcXSM0WBBznezhX4KXlNXH+6+o7xQS1QaIBcI
 6nHerIwsdHj3hq/biihEFgBQnh0tf47JCmaebcXqwsJJysrb+Ng4ME6EpuxOtzqAFhRZ
 fuSA==
X-Gm-Message-State: AA+aEWb1vjoNTcEGCfiigMJq6ywDOz/pVQUA6LhQsv/0UZX4Zp9DtQBW
 UmVxVJB+hkfcHg5qXNk2T8VqSaZf
X-Google-Smtp-Source: AFSGD/UU1B3pS4S9l0H9/oaTAjE+5XQw6rFAQOj7FhZkQReyBXrI2R7Qvz+fwycKt4rbQ6WP2B+zEA==
X-Received: by 2002:a50:d085:: with SMTP id v5mr10800842edd.61.1544435898184; 
 Mon, 10 Dec 2018 01:58:18 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id y16sm3224804edb.41.2018.12.10.01.58.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 01:58:17 -0800 (PST)
Date: Mon, 10 Dec 2018 10:58:16 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 05/10] mailbox: tegra-hsp: Add suspend/resume support
Message-ID: <20181210095816.GB15154@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-6-thierry.reding@gmail.com>
 <9a7a55fa-9989-21cd-f981-f43d3b0f2d6c@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <9a7a55fa-9989-21cd-f981-f43d3b0f2d6c@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_015829_819452_048A3598 
X-CRM114-Status: GOOD (  25.92  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Mika Liljeberg <mliljeberg@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1418119014636887706=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1418119014636887706==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 11:17:58AM +0000, Jon Hunter wrote:
>=20
> On 12/11/2018 15:18, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Upon resuming from a system sleep state, the interrupts for all active
> > shared mailboxes need to be reenabled, otherwise they will not work.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/mailbox/tegra-hsp.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> > index 0100a974149b..1259abf3542f 100644
> > --- a/drivers/mailbox/tegra-hsp.c
> > +++ b/drivers/mailbox/tegra-hsp.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm.h>
> >  #include <linux/slab.h>
> > =20
> >  #include <dt-bindings/mailbox/tegra186-hsp.h>
> > @@ -817,6 +818,23 @@ static int tegra_hsp_remove(struct platform_device=
 *pdev)
> >  	return 0;
> >  }
> > =20
> > +static int tegra_hsp_resume(struct device *dev)
> > +{
> > +	struct tegra_hsp *hsp =3D dev_get_drvdata(dev);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < hsp->num_sm; i++) {
> > +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[i];
> > +
> > +		if (mb->channel.chan->cl)
> > +			tegra_hsp_mailbox_startup(mb->channel.chan);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);
>=20
> Is it worth disabling interrupts on suspend to avoid any in-flight
> interrupt triggering a bad access on entering suspend? I assume that the
> context of the mailbox registers get cleared/lost at some point and so I
> was not sure if there is a time where they have a bad state or are
> inaccessible?

Theoretically I think we'd have to do that. However, since we end up
having to busy-loop for any current use-cases (i.e. console) anyway,
we'll never end up in a situation where an interrupt could occur at
this point. The console will long have been suspended when we reach
this point. I'll take a look if a use-case can be constructed where
such an in-flight interrupt could be produced.

Thierry

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwOOLgACgkQ3SOs138+
s6GYsQ/9HvdB8fE3i/lxsreIZfMKBLSwsSeSeisY77tK4hAGA2C/rTAvWotc44xu
sQAzvPEGv0J6hTpPlxQRf6lwigofiPxai/u1XB8/WiUltpVKPAIMWyqKAonrO1xJ
dwJ9qP6Y9oEsDSjfcYgsjbWOpRU9AjzvUgTFihQFVCJdVb9+dt4JuJY4kJGRrijI
8dsfg/xhtw1C2jf+21XCTnxzkME6V2oRBCh1ttXE0ODGFVdz644TlzDD77ZiHv+t
ZUyEKf2RSk3yNf8spoh6PfWa6mJ6uLRsI/+SqhOpoITph8mlsVNOgdqSHj+Lqd39
cVFpxfghaCAIcnAwa2EFpDgMNcDAa0CphpUSqFczR3eiKeEnaw7vESAkqg7SayQ7
Wr13w2KE4Vhj/ZmRds1gx5WOsS6l2OK6zmwTCf3EEA8tFy67Bfot5eAbHcwKf6yv
SqOHfvvulhPhsmvfsAR1O1MCEIEeNK+DfqQvT5NclhvqAIbWuLgf1Ksh0j40ljxC
uXW3+KeHVFiHP+kSorKnueF7SGulsSwzmv1s79KgxCws7cvzDCw5QAGpOdeRJhSZ
9pvYY+ImjTYhxQoanpwjpxADUntz+B+1tGnAGjin7ADPrF1YJCC5uO+PvG5LGvNU
1XbaxnV6rxQdjJB/O0RhizItRckwoeFGpf/5Dgi3bKyzkzo40zU=
=34cK
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--


--===============1418119014636887706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1418119014636887706==--

