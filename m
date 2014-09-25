From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Sep 2014 00:37:20 +0100
Subject: Kprobes build failure
Message-ID: <20140925233720.GG5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, Olof's kbuild found this while building my rc5 based for-next tree:

        arm.allmodconfig:
/tmp/ccoT403o.s:21439: Error: bad immediate value for offset (4168)
/tmp/ccoT403o.s:21440: Error: bad immediate value for offset (4176)
/tmp/ccoT403o.s:21475: Error: bad immediate value for offset (4260)
/tmp/ccoT403o.s:21476: Error: bad immediate value for offset (4260)
/tmp/ccoT403o.s:23566: Error: bad immediate value for offset (4132)
/tmp/ccoT403o.s:23567: Error: bad immediate value for offset (4148)
/tmp/ccoT403o.s:23606: Error: bad immediate value for offset (4236)
/tmp/ccoT403o.s:23607: Error: bad immediate value for offset (4248)

which, when looking at the logs, appears to be:

/tmp/ccoT403o.s:47583: Error: bad immediate value for offset (5464)
make[3]: *** [arch/arm/kernel/kprobes-test-arm.o] Error 1
make[3]: Target `__build' not remade because of errors.
make[2]: *** [arch/arm/kernel] Error 2

Any ideas?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
