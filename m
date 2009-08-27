From: jsgood.yang@samsung.com (Jinsung Yang)
Date: Thu, 27 Aug 2009 11:06:56 +0000 (GMT)
Subject: Discussion request for new Samsung SoCs maintaining
Message-ID: <24498970.196691251371216483.JavaMail.weblogic@epml12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,
My name is Jinsung, Yang, I'm happy to suggest my ideas to you. Let me introduce myself first.
I am working for Samsung Electronics (System LSI/Semiconductor Business), and working on device drivers on Samsung SoCs such as s3c6410 and so on.
Recently, my team has decided to contribute our source codes to the mainline.
Following are some troubles our team is facing and solutions to them.

The latest (arm) linux mainline has some Samsung SoCs supports like s3c24xx and s3c6410, and we need to add our new SoCs which are based on arm11 and cortex-a8 architectures.
I'll give some short explanations about the line-up of Samsung SoCs:
* ARM11 family: s3c6410, s3c6430, s3c6431, s5p6440, s5p6442, ..
* Cortex-A8 family: s5pc100, s5pc110, ..

As some people know, even if some SoCs are in the same family, the prefix of SoCs are different, this is the first thing of problems.
We call that 'the naming issues', we will have discuss in detail later.. (after fixing architecture issues)

The second problem is that even though same family, the features like the memory map and internal devices (IPs) are very different.
For example, s5p6442 and s5pc110 have different arm core, but internal devices are very similar.

Otherwise, although s5p6440 and s5p6442 are in the same family, architecture and similar names, internal devices are very different.
It makes to be hard to integrate codes in a same platform directory.

Similarity of our SoCs are depends on when the chip was born rather than which arm core is included because same h/w features are used for SoC design if some projects (= different core) are going on the same period.

So that, we are considering the following platform structure to manage our new SoCs.
(All names are tentative)

linux
  |
  +-- arch
        |
        +-- arm
              |
              +-- plat-samsung2
              |
              +-- mach-samsung2
              |         |
              |         +-- mach-smdk6440.c
              |         +-- mach-smdkc100.c
              |         +-- ...
              |
              +-- plat-samsung3
              |
              +-- mach-samsung3
              |         |
              |         +-- mach-smdk6442.c
              |         +-- mach-smdkc110.c
              |         +-- ...

This layout is based on the time of products, not what the core is in.
(The names like plat-samsung2 are not decided, just be used to explain our layout)

The plat-samsung2 and plat-samsung3 directories include common implementations for those groups, as you guess, mach-samsung2 and mach-samsung3 directories support board specific files.

Anyone has better idea?

We hope and need to discuss our ideas more and more, continuously, so tell us your opinions and something like this freely about this and, because s3c6410 supports is already in the mainline, we should handle this SoC specially.

Also we are considering the single binary compilation/operation for the same arm architecture.
Finally, we should talk with Ben Dooks who is a maintainer of s3c24xx series, so hope Ben's reply especially :)

Thank you,
--
Jinsung, Yang <jsgood@samsung.com>
Samsung Electronics, Co., Ltd.
