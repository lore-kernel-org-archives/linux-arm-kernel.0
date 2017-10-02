From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 2 Oct 2017 12:08:06 +0100
Subject: [PATCH 1/5] firmware: arm_scpi: remove usage of drvdata and don't
 reset scpi_info to null
In-Reply-To: <e078f057-9872-9073-876a-1c0c9312f58d@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
 <e078f057-9872-9073-876a-1c0c9312f58d@gmail.com>
Message-ID: <a5f3c429-c125-4f44-0f28-5e1240093fbe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/09/17 22:43, Heiner Kallweit wrote:
> I do not see a benefit in using drvdata as variable scpi_info is
> available everywhere anyway.
> 

I will reword above before committing as:
"There's no benefit using drvdata as variable scpi_info is global"

> And setting scpi_info to NULL in scpi_remove isn't needed IMO.
> If arm_scpi is built-in, then this code is never used. And if arm_scpi
> is built as a module and some other module calls get_scpi_ops() then
> due to this dependency scpi_remove is called only after the other
> module has been removed. Last but not least users usually store the
> result of get_scpi_ops(), therefore setting scpi_info to NULL wouldn't
> really help.
> 

Agreed. I am fine with the change. Only issue I see is to support
multiple instances of SCPI on a platform, but that may need more rework
anyways.

-- 
Regards,
Sudeep
