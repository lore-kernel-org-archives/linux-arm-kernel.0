From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 22 Nov 2010 11:20:38 +0000
Subject: [PATCH v6 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <AANLkTikYu4H8aWOvK+q6g4YgUZxD_80UKBdr=eB__frF@mail.gmail.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-9-git-send-email-cyril@ti.com>
	<4CE97AE5.3040801@bluewatersys.com>
	<AANLkTikYu4H8aWOvK+q6g4YgUZxD_80UKBdr=eB__frF@mail.gmail.com>
Message-ID: <20101122112038.GD16504@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 21, 2010 at 02:31:38PM -0700, Grant Likely wrote:
> On Sun, Nov 21, 2010 at 1:02 PM, Ryan Mallon <ryan@bluewatersys.com> wrote:

> > Currently the code will allow you to install
> > several peripherals at once, which will lead to odd behaviour at
> > runtime. Maybe a better approach would be to have something like this in
> > drivers/mfd/ti-ssp.c:

> Only the ssp core itself is allowed to register the peripheral
> devices, and so using the parent pointer is perfectly valid.  I think
> Cyril's approach is fine.

This is very much a standard idiom for MFD children in Linux - if the
children are entirely reliant on working through a parent-specific API
anyway there's no issue with making the parent device be part of that
API.
