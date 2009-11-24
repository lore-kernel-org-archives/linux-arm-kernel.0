From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 25 Nov 2009 00:25:41 +0300
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
In-Reply-To: <20091123203931.GI18142@n2100.arm.linux.org.uk>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<20091024211026.GE16451@n2100.arm.linux.org.uk>
	<20091025153603.GA24490@rainbow> <20091115173048.GA19609@rainbow>
	<20091123203931.GI18142@n2100.arm.linux.org.uk>
Message-ID: <20091124212541.GA5751@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:39 Mon 23 Nov     , Russell King - ARM Linux wrote:
> > I'm thinking about submitting full patchset into you patchsystem soon,
> > but I'd like to know that everything is ok before doing that.
> 
> Well, I'm not sure what Thomas Kunze is doing, I've not heard from him in
> a while.
> 
> How do your patches affect his?  Are your patches a superset of Thomas's
> patches?  If not, should Thomas's be merged first?

Mine and Thomas patchsets are pretty independent - not even a file in
common, and they don't depend on each other even indirectly.

But mine depends on changes in your 'sa1100' branch, and I've been slightly
worrying about this commit:  "ARM: sa11x0: convert set_xxx_data() to
register_xxx()", which touches collie.c. Though, looks like it doesn't
conflict with Thomas's patches in fact (I've made a test 'git merge' just
to be sure).

Oh, and forgot to mention - your 'sa1100' branch is currently based on
2.6.32-rc3, you'll need to rebase it on more current -rc before applying
my patches, because of 4918a0139 (ARM: 5752/1: SA1100: fix building of
h3100), which went in -rc4.

-- 
Best regards,
Dmitry "MAD" Artamonow
