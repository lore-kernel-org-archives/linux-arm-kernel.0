From: mathew.li100@gmail.com (Mathew Li)
Date: Mon, 9 Jun 2014 11:44:29 -0700
Subject: Some SMP related questions
Message-ID: <CALU2kfkrpoSSpRB-XGeKS5DOGRCKapRT_qhZW+u4MOsviOx3QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just trying to understand SMP arm Linux. I have following questions:

1. On any ARM board, all the devices raise SPIs. Is that correct?
2. On an SMP system, how does Linux configure SPIs? I mean the routing
of the interrupts. For example, when a device raises an interrupt,
does it get seen by all the cpus or is it seen only by the boot cpu,
who handles the interrupt eventually if it is seen by all the cpus?
Could you also please point me to the code?
3. On an SMP system, how does Linux do scheduling? What is used for
scheduling, I believe it is the timer interrupt. Right? Is timer
device and its interrupt private to the cpu or is it also global? If
global then which cpu gets to serve the timer interrupt?
4. In an SMP system, is it possible to run a process on a given cpu
and never schedule it out until the process itself makes some blocking
call, leading to a call into schedule() in kernel? Essentially I am
saying to assign infinite time quantum to the process and only
schedule it out when it does a blocking call.
5. Is it possible to configure and build linux in an ASMP way? For
example, so that whole kernel logic runs on boot cpu and remaining
cpus would be used only and only for processes?

Thanks a lot in advance!
Mathew
