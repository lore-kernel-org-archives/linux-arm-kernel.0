From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 18 Mar 2014 12:17:39 -0500
Subject: [PATCH v4] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <CAASgrz0SaoNGb+ss6ZS+Zh_NoBzmznaneRur7xzp4_dyGb-wMg@mail.gmail.com>
References: <1394734769-32760-1-git-send-email-nathan_lynch@mentor.com>
 <CAASgrz0SaoNGb+ss6ZS+Zh_NoBzmznaneRur7xzp4_dyGb-wMg@mail.gmail.com>
Message-ID: <53287FB3.1050103@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 03/17/2014 07:49 PM, David Riley wrote:
> Hi Nathan,
> 
> I gave this a try against a 3.10 system and ran into issues when
> vdso.so grew to two pages because of of a large .GCC.command.line
> section.  __get_datapage was returning an address that was at the
> beginning of the second code page instead of the data page since it
> didn't account for the additional section.  I got it working by adding
> .GCC.command.line to the DISCARD group in the linker script, but in
> general it feels as if this code is a bit fragile since it depends on
> knowing exactly which sections exist in the .so for the _vdso_data
> symbol to be correct.

Thanks for giving this a try and reporting the issue.  I'm guessing you
use -frecord-gcc-switches.  I agree this aspect of the vDSO could be
more robust -- at least the build should be made to fail when wrong code
is generated.

I'll look into it, and I'd appreciate any suggestions or additional
review, especially of the linker script.
