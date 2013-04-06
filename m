From: kevin@bracey.fi (Kevin Bracey)
Date: Sat,  6 Apr 2013 15:37:03 +0300
Subject: [PATCH] cpu_kill/cpu_die coordination
Message-ID: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been having problems handshaking between cpu_kill and cpu_die, due to the
fact that they don't always occur together. It seems to me that this patch is
basically what's needed. I'm working on 3.4-based code, but the logic doesn't
seem to have changed since then.

Searches didn't show much activity in this area - it appears that I'm on the
only upstream platform actually implementing cpu_kill, which may explain why
it's not been noticed.

Only related topic I found was this discussion:

     https://patchwork.kernel.org/patch/1898311/

which could maybe be short-circuited by this patch.

Kevin Bracey (1):
  ARM: smp: call platform's cpu_die in ipi_cpu_stop

 arch/arm/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.8.2.445.gfcda34b
