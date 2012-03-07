From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Mar 2012 11:10:19 -0700
Subject: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
In-Reply-To: <1331103163.2048.33.camel@epip-laptop>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>	
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
 <1331103163.2048.33.camel@epip-laptop>
Message-ID: <4F57A48B.1060100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 11:52 PM, Guan Xuetao wrote:
> On Tue, 2012-03-06 at 17:30 -0700, Stephen Warren wrote:
>> This allows the user to use U-Boot's mkimage's -T kernel_noload option
>> if their arch Kconfig allows it, and they desire.
...
> Hi, Stephen,
> It seems that UIMAGE_ARCH and UIMAGE_LOADADDR can't be modified from
> arch-Makefiles.

Oh dear, you're right. I suck at testing:-( I've fixed this locally.

For reference, Makefile.lib is included after the Makefile in the
relevant source directory, whereas my patch assumed the other way
around. So, rather than setting defaults in Makefile.lib and having
foo/Makefile override them, I should set the non-defaults in
foo/Makefile, and have Makefile.lib provide default values for variables
that aren't already set. Testing indicates this solves the problem!
