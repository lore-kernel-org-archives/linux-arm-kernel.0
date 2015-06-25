From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Jun 2015 15:27:33 +0200
Subject: [PATCH 0/2] ARM-kernel: Deletion of unnecessary checks before two
 function calls
In-Reply-To: <5317A59D.4@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Message-ID: <558C01C5.4060303@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>

Some functions tolerate the passing of a null pointer. I do not see a need
because of this fact that a function caller repeats a corresponding check.

Markus Elfring (2):
  Delete a check before the function call "smp_set_ops"
  Delete a check before the function call "unwind_table_del"

 arch/arm/kernel/module.c | 3 +--
 arch/arm/kernel/setup.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.4.4
