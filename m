From: vaibhav.bedia@gmail.com (Vaibhav Bedia)
Date: Sat, 23 Nov 2013 12:23:35 -0500
Subject: [rtc-linux] Re: [PATCH v4 0/4] pm: Add power off control
In-Reply-To: <20131122195041.GF18968@localhost>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
 <CA+Bv8XbUa7xPd8V7LQCmFbbdQvORUK1X0xBPzAhKUFFjjho2jw@mail.gmail.com>
 <20131122195041.GF18968@localhost>
Message-ID: <CANacCWxwr7s6ZvjWRbg_JGgc-Q1sJa-KJCLrSCK4BvSrmL5Eug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 2:50 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
[...]
>
> And why specifically *2* seconds, instead of *1* or *33* ?
>
> Sounds a bit like voodoo magic on this side :-)

Consider the scenario where the actual time is 00:00:01.95 secs.
Due to the 1 second resolution of the RTC, reading the registers
would return 00:00:01. By the time we get to updating the
RTC register for the shutdown by adding 1 sec (theoretically the
smallest delta) we could end up programming the time that's already
passed and in such cases the system will never shut down.

2 secs is the smallest delay that we can use to get the system
to shutdown reliably.

So it's not voodoo magic after all ;)

Regards,
Vaibhav
