From: me@felipebalbi.com (Felipe Balbi)
Date: Sat, 20 Nov 2010 13:31:09 +0200
Subject: [PATCH v3 5/5] OMAP: mailbox: add notification support for
	multiple readers
In-Reply-To: <AANLkTi=OH1y=Q39yqd5m+PXEvM1pX6p_SmH_HFYDHHsK@mail.gmail.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	<20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	<AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	<20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	<AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
	<20101119125353.GB5818@legolas.emea.dhcp.ti.com>
	<AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
	<1290176736.15533.17.camel@eowin>
	<AANLkTi=EMBrb0eHZyzPen2DHGR4ARh1T8ojT7jOVQ67u@mail.gmail.com>
	<1290208036.15533.24.camel@eowin>
	<AANLkTi=OH1y=Q39yqd5m+PXEvM1pX6p_SmH_HFYDHHsK@mail.gmail.com>
Message-ID: <1290252669.15533.28.camel@eowin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hari,

On Fri, 2010-11-19 at 22:01 -0600, Kanigeri, Hari wrote:
> Of course :), profiling was done before releasing this code and no
> difference observed with or without blocking notifier. All the OMAP4

would you share some numbers ?

> use cases are exercising this code. Just curious , are you doubting
> the blocking notifier mechanism ?

a little bit. Yeah. It added about 600ms of time spent on musb's probe
when we were using blocking notifier for charger detection. When we
moved to atomic notifier, that was solved. Anyway, you can never be sure
when that will be scheduled and if cpu is really busy, it might pose a
great deal.

-- 
balbi
