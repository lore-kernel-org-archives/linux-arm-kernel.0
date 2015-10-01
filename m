From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Thu, 01 Oct 2015 20:51:59 +0200
Subject: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is
 0 based on sunxi SoCs
In-Reply-To: <20150929120943.GP7104@lukather>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl> <20150929120943.GP7104@lukather>
Message-ID: <560D80CF.6050500@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Maxime,

On 29-09-15 14:09, Maxime Ripard wrote:
> On Sun, Sep 27, 2015 at 06:05:35PM +0200, Olliver Schinagl wrote:
>> Hey Hans,
>>
>> On 27-09-15 16:57, Hans de Goede wrote:
>>> According to the datasheets to n factor for dividing the tclk is
>>> 2 to the power n on Allwinner SoCs, not 2 to the power n + 1 as it is
>>> on other mv64xxx implementations.
>> Ah!
>>> I've contacted Allwinner about this and they have confirmed that the
>>> datasheet is correct.
>>>
>>> This commit fixes the clk-divider calculations for Allwinner SoCs
>>> accordingly.
>> So this explains why all my i2c frequenties are double of what I setup.
>> Thanks for taking the time of figuring it out! I'll give it a test hopefully
>> soon.
> It would have been great to let us know...
If your talking about past tence, I actually did ;) [0][1] and I 
actually had a tree made ready just 3 weeks ago with 3.15 to start my 
bisection with. It seemed logical to see if it worked there as that was 
the first iteration (based on the sunxi/allwinner based tree before the 
mv migration.

Anyway, I even built tried to build the kernel! but my gcc failed to 
build it so i put it on the back-burner for a while.

WIth Hans having figured it out and fixing it, I'll absolutly will take 
a nother look and check with a scope if it all works out now.

Olliver

[0] http://irclog.whitequark.org/linux-sunxi/2015-01-16#11522114;
[1] http://s24.postimg.org/yiykh6kkl/DS1_Z_Quick_Print2.png


> Maxime
>
