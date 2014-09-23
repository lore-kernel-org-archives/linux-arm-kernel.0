From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 23 Sep 2014 13:25:17 +0800
Subject: unalignment access to device / strongly ordered memory
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB491629@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

I have a question about
unalignment access to device / strongly ordered memory.
The TRM said that :

Unaligned data accesson page A3-108identifies the instructions that can make an unaligned memory 
access, and the required configuration setting. If such an access is to Device or Strongly-ordered memory 
then:
- if the implementation does not include the Virtualization Extensions, the effect is UNPREDICTABLE
- if the implementation includes the Virtualization Extensions, the access generates an Alignment fault.


But I see arch\arm\mm\alignment.c,
It don't check if the fault address is a device / strongly ordered memory address.
Is it safe ?
Do we need check it and then panic kernel or kill the user process
If the fault address is device / strongly ordered memory before simulate the unalign access?

Thanks
