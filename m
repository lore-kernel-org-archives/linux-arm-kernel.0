From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 10 May 2013 16:09:14 +0100
Subject: [PATCH RFC 0/2] clk: add metag specific gate/mux clocks
In-Reply-To: <1368198127-1295-4-git-send-email-james.hogan@imgtec.com>
References: <1368198127-1295-1-git-send-email-james.hogan@imgtec.com>
 <1368198127-1295-4-git-send-email-james.hogan@imgtec.com>
Message-ID: <518D0D9A.5080502@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/13 16:02, James Hogan wrote:
> This adds a metag architecture specific clk-gate and clk-mux which
> extends the generic ones to use global lock2 to protect the register
> fields. It is common with metag to have an RTOS running on a different
> thread or core with access to different bits in the same register (which
> contain clock gate/switch bits for other clocks). Access to such
> registers must be serialised with a global lock such as the one provided
> by the metag architecture port in <asm/global_lock.h>

Hmm, sorry about the duplicated emails, I had *.patch twice in my git
send-email command line :(.
