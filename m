From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 17 Jun 2016 06:15:07 +0300
Subject: [PATCH V2 11/63] clocksource/drivers/digitcolor: Convert init
 function to return error
In-Reply-To: <1466112442-31105-12-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-12-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20160617031507.GQ2749@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Jun 16, 2016 at 11:26:30PM +0200, Daniel Lezcano wrote:
> The init functions do not return any error. They behave as the following:
> 
>   - panic, thus leading to a kernel crash while another timer may work and
>        make the system boot up correctly
> 
>   or
> 
>   - print an error and let the caller unaware if the state of the system
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

It would be nice to have at least LAKL on Cc of the cover letter as well, so 
we can get the big picture. I found it at 
http://article.gmane.org/gmane.linux.kernel/2246137.

But anyway, for this and the final patch:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
