From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 31 May 2013 19:02:49 +0800
Subject: A bug about system call on ARM
In-Reply-To: <20130531084638.GB4928@mudshark.cambridge.arm.com>
References: <CAFLxGvy39xWdZmtiVHP+y=zH1coCVmMuREcmD25wSb=w-VK7Xg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D1610991B85D@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
 <CAFLxGvyy=73dGQqG8W6SXZah7WQZ4gJAeeHXN8opKaOuG-5yUQ@mail.gmail.com>
 <20130529094826.GD13095@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
 <20130530090949.GC7483@mudshark.cambridge.arm.com>
 <20130530114112.GH7483@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B86D@CNBJMBX05.corpusers.net>
 <20130531084638.GB4928@mudshark.cambridge.arm.com>
Message-ID: <35FD53F367049845BC99AC72306C23D1610991B874@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  Will,

I have merge your code ,
But there is a different ,

+	
+	ct_user_exit
+
+#ifdef CONFIG_ALIGNMENT_TRAP
+	ldr	ip, __cr_alignment
+	ldr	ip, [ip]
+	mcr	p15, 0, ip, c1, c0		@ update control register
+#endif 

+	enable_irq
+	get_thread_info tsk

Is this change ok ?


Thanks 

-----Original Message-----
From: linux-arch-owner@vger.kernel.org [mailto:linux-arch-owner at vger.kernel.org] On Behalf Of Will Deacon
Sent: Friday, May 31, 2013 4:47 PM
To: Wang, Yalin
Cc: 'richard -rw- weinberger'; 'linux-arch at vger.kernel.org'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'
Subject: Re: A bug about system call on ARM

On Fri, May 31, 2013 at 03:56:31AM +0100, Wang, Yalin wrote:
> Hi Will,
> 
> Thanks for your patch ,
> 
> But I found  I don't have ct_user_exit  macro In my 
> arch/arm/kernel/entry-common.S
> 
> My kernel version is 3.4.0

Well things have moved on this since then (we're approaching 3.10, so you might consider an upgrade!).

For the purposes of this patch, you can just delete the ct_user_exit line.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in the body of a message to majordomo at vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
