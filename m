From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 4 Jun 2013 13:33:20 +0800
Subject: A bug about system call on ARM
In-Reply-To: <35FD53F367049845BC99AC72306C23D1610991B87E@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
 <20130530090949.GC7483@mudshark.cambridge.arm.com>
 <20130530114112.GH7483@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B86D@CNBJMBX05.corpusers.net>
 <20130531084638.GB4928@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B874@CNBJMBX05.corpusers.net>
 <20130531111305.GI4928@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B876@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B87B@CNBJMBX05.corpusers.net>
 <20130603095425.GA32242@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B87E@CNBJMBX05.corpusers.net>
Message-ID: <35FD53F367049845BC99AC72306C23D1610991B883@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  Will,

Could I know  what's your git branch is  mainly used for ?

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git


I mean if the branch is used for ARM arch maintenance ?
If yes, I think I can send future bugs about ARM to you directly,
And do not need ping-pang in the mail list .

Thanks for your help .

-----Original Message-----
From: Wang, Yalin 
Sent: Monday, June 03, 2013 5:58 PM
To: 'Will Deacon'
Cc: 'richard -rw- weinberger'; 'linux-arch at vger.kernel.org'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'
Subject: RE: A bug about system call on ARM

Hi  Will

Oh  I see,
Thanks for your reply 

Yes ,  we are testing for it ,
But need some time to wait for the result , Because The stability test need some time to reproduce this issue , And this issue doesn't reproduce 100% .


-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com]
Sent: Monday, June 03, 2013 5:54 PM
To: Wang, Yalin
Cc: 'richard -rw- weinberger'; 'linux-arch at vger.kernel.org'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'
Subject: Re: A bug about system call on ARM

On Mon, Jun 03, 2013 at 06:25:26AM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> I have a question about this patch .
> 
> If the user space is thumb mode,
> The PC should be rewind by 2 bytes,
> So the fix_up code should be
> 
> Sub lr, lr, #2 .
> 
> 
> Am I right ?

No, because we don't have OABI-compat support for Thumb applications and force everything down the EABI path instead.

Did you manage to test the patch?

Will
