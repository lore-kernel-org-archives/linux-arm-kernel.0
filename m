From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 15:44:14 +0530
Subject: [PATCH, RFC 2/8] ARM: twd: register clock event for 1 core SMP
In-Reply-To: <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361186097.git.afzal@ti.com>
Message-ID: <51235076.8040200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013 05:07 PM, Afzal Mohammed wrote:
> Register percpu local timer for scheduler tick in the case of one core
> SMP configuration. In other cases - secondary cpu's as well as boot
> cpu's having more than one core, this is being registered as per
> existing boot flow, with a difference that they happens after delay
> calibration. Registering the clock for tick in case of one core should
> be done before Kernel calibrates delay (this is required to boot,
> unless local timer is the only one registered for tick). Registering
> twd local timer at init_time (which platforms are doing now) helps
> achieve that with the proposed change.
>
> This helps in an almost booting Kernel (minimal) by only relying on
> ARM parts for an A9 one core SMP.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
As mentioned in cover-letter, I don't think we have good
reasoning to make TWD to work with UP configuration. Even
you fix the timer code, there are more cascaded dependencies
which is not worth the effort.

Regards,
Samtosh
