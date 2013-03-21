From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 21 Mar 2013 11:19:31 +0900
Subject: [PATCH for 3.9-rc] arm: mvebu: Use local interrupt only for the
 timer 0
In-Reply-To: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
References: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <514A6E33.6060600@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/03/21 0:09), Gregory CLEMENT wrote:
> The commit 3a6f08a37 "arm: mvebu: Add support for local interrupt",
> managed the 28th first interrupts as local interrupt to match the
> hardware specification. Among these interrupts there are the Gigabits
> Ethernet ones used by the mvneta driver. Unfortunately the state of
> the percpu_irq API prevents the driver to use it.
> 
> Indeed the interrupts have to be freed when the .stop() function is
> called. As the free_percpu_irq() function don't disable the interrupt
> line, we have to do it on each CPU before calling this. The function
> disable_percpu_irq() only disable the percpu on the current CPU and
> there is no function which allows to disable a percpu irq on a given
> CPU. Waiting for the extension of the percpu_irq API, this fix allows
> to use again the mvneta driver.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Hi,

I've tested this too.

Tested-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Thank you!

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
