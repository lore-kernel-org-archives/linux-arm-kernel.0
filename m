From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 26 Jul 2013 11:52:36 +0100
Subject: fyi - kprobes testing patches
In-Reply-To: <1374786537-10726-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1374786537-10726-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <51F254F4.5020900@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/13 22:08, Ben Dooks wrote:
> I've been working on kprobes and the kprobes-test driver. It seems
> there are more issues with the kprobes-test that need looking in to
> so I am putting this series out to see if anyone has any comments

the testing logs show a few failures with BE8 mode, however with the
patch series applied the kernel no longer oopses during testing.
                 > FAIL: registers differ 

> FAIL: Test mov  pc, r0, asl r1
> FAIL: Scenario 0
> initial_regs:
> r0  8001b37c | r1  00000000 | r2  21522352 | r3  21522252
> r4  21522552 | r5  21522452 | r6  21522752 | r7  21522652
> r8  21522952 | r9  21522852 | r10 21522b52 | r11 21522a52
> r12 21522d52 | sp  9f847dd4 | lr  21522f52 | pc  8001b370
> cpsr 00000213
> expected_regs:
> expected_regs:
> r0  8001b37c | r1  00000000 | r2  21522352 | r3  21522252
> r4  21522552 | r5  21522452 | r6  21522752 | r7  21522652
> r8  21522952 | r9  21522852 | r10 21522b52 | r11 21522a52
> r12 21522d52 | sp  9f847dd4 | lr  21522f52 | pc  8001b374
> cpsr 00000213
> result_regs:
> r0  8001b37c | r1  00000000 | r2  21522352 | r3  21522252
> r4  21522552 | r5  21522452 | r6  21522752 | r7  21522652
> r8  21522952 | r9  21522852 | r10 21522b52 | r11 21522a52
> r12 21522d52 | sp  9f847dd4 | lr  21522f52 | pc  8001b37c
> cpsr 00000213




-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
