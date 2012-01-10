From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 Jan 2012 10:29:59 -0800
Subject: [PATCH-V2 1/2] arm:omap:am33xx: Add voltage domain data
In-Reply-To: <1324803628-16790-2-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Sun, 25 Dec 2011 14:30:27 +0530")
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-2-git-send-email-hvaibhav@ti.com>
Message-ID: <87ipkjpg0o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Currently dummy voltage domain data is being created
> in order to succeed boot process, nothing has been done
> w.r.t actual hardware (voltage control).
>
> Also, hook up the AM33XX voltage domain to OMAP framework.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Data looks OK, but why the dummy voltage domains?   Does this device not
support voltage scaling? 

Also, I think it was my idea in an earlier review to add the 
'.scalable = false', but it's not really necessary since the default is
false.  Sorry 'bout that.

Kevin
