From: nm@ti.com (Nishanth Menon)
Date: Fri, 10 May 2013 09:02:00 -0500
Subject: [PATCH v2 0/6] ARM; OMAP2+: hwmod and SERIAL: Remove sysc
 handling from driver
In-Reply-To: <87ppxhxixu.fsf@linaro.org>
References: <1366973695-2088-1-git-send-email-rnayak@ti.com>
 <87ppxhxixu.fsf@linaro.org>
Message-ID: <20130510140200.GA11267@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:09-20130426, Kevin Hilman wrote:
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> [...]
> 
> > OMAP UART IP needs manual idle modes based on functional state of the
> > IP. Currently this is handled by the driver with function pointers
> > implemented in platform code.
> >
> > This however breaks in case of device tree because of missing
> > idle handling. 
> >
> > The series tries to address the issue and tries to remove complete
> > sysc handling from serial driver.
> 
> Other than the minor nit about the order of the series for bisect, 
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> Also tested this on OMAP4/Panda where I was having the sluggish console
> issues using DT boot, and and can confirm that this fixes the problem:
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda
> 
I saw the same let of console sluggishness on SDP4430, Panda, Panda-ES
as well on latest linus master.

For reference, I have rebased the series to latest master and fixes the
sequencing:
https://github.com/nmenon/linux-2.6-playground/commits/push/uart-fixes-sidle-3.10
based on:
master 70eba42 Merge tag 'please-pull-pstore' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux

Rajendra,
Would you be able to repost this series so that we can get this into
3.10-rc2+?

-- 
Regards,
Nishanth Menon
