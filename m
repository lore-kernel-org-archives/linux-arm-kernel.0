From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 05 Sep 2018 17:49:31 +0200
Subject: [PATCH v8 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <f15e355ece0b250a252347ec22f1433dd786bb5b.camel@collabora.com>
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-5-paul.kocialkowski@bootlin.com>
 <f15e355ece0b250a252347ec22f1433dd786bb5b.camel@collabora.com>
Message-ID: <383bf546272ac7edca5a5f502fce4cafa88a3321.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le mardi 28 ao?t 2018 ? 22:08 -0300, Ezequiel Garcia a ?crit :
> On Tue, 2018-08-28 at 09:34 +0200, Paul Kocialkowski wrote:
> > +static const struct v4l2_m2m_ops cedrus_m2m_ops = {
> > +	.device_run	= cedrus_device_run,
> > +	.job_abort	= cedrus_job_abort,
> > +};
> > +
> 
> I think you can get rid of this .job_abort. It should
> simplify your .device_run quite a bit.
> 
> .job_abort is optional now since
> 5525b8314389a0c558d15464e86f438974b94e32.

Alright, I will probably do that for the next revision, since it seems
that there is no particular downside to removing it.

Thanks,

Paul

> Regards,
> Ezequiel

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/ede4ff8e/attachment.sig>
