From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Mon, 26 Aug 2013 17:36:22 +0200
Subject: [PATCH 0/3] Interrupt priority patch set
Message-ID: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI spec is x86 oriented thus it use NMI for error reporting as low latency
error signalling way. Fast response to error occurrence is what ARM trying to
satisfy using interrupt prioritization since there is no NMI direct equivalent
for ARM architecture. 

Patch set are divided into three step:
1. Create generic code responsible for setting interrupt priority.
2. Use it in interrupt setup.
3. Example of interrupt controller priority mapping for GIC platform dependent
   code.

Patch set tries to meet requirements like:
- not breaking existing code
- easy to expand to new priority levels
- easy to map generic priority levels to platform dependent priority values

See commit logs for more detailed explanation.
