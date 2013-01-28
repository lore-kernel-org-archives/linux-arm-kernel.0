From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Jan 2013 08:43:25 +0000
Subject: [PATCH 05/26] mfd: ab8500-gpadc: Change to mdelay for greater
 resolution
In-Reply-To: <20130127235239.GM1174@sortiz-mobl>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-6-git-send-email-lee.jones@linaro.org>
 <20130127235239.GM1174@sortiz-mobl>
Message-ID: <20130128084325.GA15873@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Samuel Ortiz wrote:

> Hi Lee, Jonas,
> 
> On Tue, Jan 15, 2013 at 12:55:45PM +0000, Lee Jones wrote:
> > From: Jonas Aaberg <jonas.aberg@stericsson.com>
> > 
> > The resolution of msleep is related to HZ, so with HZ set to
> > 100 any msleep of less than 10ms will become ~10ms.
> usleep_range would be more appropriate, sleeping should be preferred over
> spinning.

I believe this patch was written before usleep_range() was around. This
is addressed in a latter patch. Please allow this one in for a)
historical reasons (trying to keep the development history) and b) to
prevent any conflicts when we do reach the fixup patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
