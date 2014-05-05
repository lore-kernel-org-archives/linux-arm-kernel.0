From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 May 2014 09:45:19 -0400 (EDT)
Subject: [PATCH] arm: put_user: fix possible data corruption in
 put_user
In-Reply-To: <53676D12.9040300@samsung.com>
References: <1399270438-26181-1-git-send-email-a.ryabinin@samsung.com>
 <20140505090126.GD3693@n2100.arm.linux.org.uk> <53676D12.9040300@samsung.com>
Message-ID: <alpine.LFD.2.11.1405050944001.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 May 2014, Andrey Ryabinin wrote:

> On 05/05/14 13:01, Russell King - ARM Linux wrote:
> > On Mon, May 05, 2014 at 10:13:58AM +0400, Andrey Ryabinin wrote:
> >> According to arm procedure call standart r2 register is call-cloberred.
> >> So after the result of x expression was put into r2 any following
> >> function call in p may overwrite r2. To fix this, the result of p
> >> expression must be saved to the temporary variable before the
> >> assigment x expression to __r2.
> > 
> > This and the patch make no sense.  You talk about r2, but you're doing
> > nothing with r2 in the patch.
> > 
> 
> No, you didn't get it. I'll try to explain better.
> 
> Lets consider following example:
[...]

Thanks for the test code.  I do confirm there is indeed a problem.

I'm trying to make sure your patch is actually the best fix.


Nicolas
