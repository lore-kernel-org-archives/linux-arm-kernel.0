From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 20 Jan 2011 18:00:04 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
Message-ID: <201101201800.04289.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 January 2011 17:09:00 Bj?rn Forsman wrote:
> Hi,
> 
> On my Colibri PXA310, I see that Linux udelay() is only 30 % of the
> length it's supposed to. This is way off and cause problems (e.g.
> 1-Wire device driver breaks). I'm running OpenPXA bootloaders (OBM2 +
> U-Boot) and mainline Linux 2.6.36.
> 
> Any ideas how to fix this?
> 
> Could it be that U-Boot sets up the system clock to something
> different than what Linux "expects" so that loops_per_jiffy becomes
> wrong? I see some clock setup in <u-boot-pxa>/arch/arm/cpu/pxa/start.S
> but I'm not sure what to do with it (yet). I'd like to try out
> different clock speeds to see if it helps. Any pointers?
> 
> I also have a workaround in mind: Try out different lpj= settings on
> the kernel command line until a udelay(1000) actually is 1000 us. Is
> this a sane thing to do?

CCing relevant people.

And no, linux kernel should derive it's timing properly so it's a kernel bug.

Cheers
> 
> Best regards,
> Bj?rn Forsman
> 
> ---------------------------------------------------------------------------
> --- Protect Your Site and Customers from Malware Attacks
> Learn about various malware tactics and how to avoid them. Understand
> malware threats, the impact they can have on your business, and how you
> can protect your company and customers by using code signing.
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> Openpxa-users mailing list
> Openpxa-users at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openpxa-users
