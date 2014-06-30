From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 30 Jun 2014 09:03:18 -0700
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <20140627085125.GA7088@hal>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140627085125.GA7088@hal>
Message-ID: <53B18A46.1050902@mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 01:51 AM, Jan Glauber wrote:
> On Sun, Jun 22, 2014 at 10:11:49PM -0500, Nathan Lynch wrote:
>> Provide fast userspace implementations of gettimeofday and
>> clock_gettime on systems that implement the generic timers extension
>> defined in ARMv7.  This follows the example of arm64 in conception but
>> significantly differs in some aspects of the implementation (C vs
>> assembly, mainly).

Sorry for replying to the wrong email in the thread -- my gmane feed 
missed the original.

One thing that might be nice to add is AT_VDSO_FINDSYM [1].  A lot of 
userspace implementations (especially for static, embedded things) might 
significantly prefer that style of entry point.

If you want to use vdso2c for vdso image post-processing, I'd be happy 
to try to make it available outside arch/x86 and to make it more 
configurable as needed.

Please use _install_special_mapping instead of install_special_mapping. 
  AFAICS it's basically impossible to use install_special_mapping correctly.

[1] 
https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=x86/vdso_findsym

--Andy
