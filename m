From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 15:29:09 +0000
Subject: [PATCH 19/22] ARM: CPU hotplug: move cpu_killed completion to
	core code
In-Reply-To: <AANLkTikiQEVdiRwPAa+HffJktNy7Aic-CHCvvBXubp_J@mail.gmail.com>
References: <AANLkTikiQEVdiRwPAa+HffJktNy7Aic-CHCvvBXubp_J@mail.gmail.com>
Message-ID: <20101208152908.GJ9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 08:53:58AM +0100, Vincent Guittot wrote:
> On 3 December 2010 21:37,  <linux-arm-kernel-request@lists.infradead.org> wrote:
> > ?/*
> > ?* called on the thread which is asking for a CPU to be shutdown -
> > ?* waits until shutdown has completed, or it is timed out.
> > ?*/
> > ?void __cpu_die(unsigned int cpu)
> > ?{
> > + ? ? ? if (wait_for_completion_timeout(&cpu_died, 5000)) {
> 
> Shouldn't you test the opposite like with platform_cpu_kill below ?

Yes, I looked at that a number of times and couldn't make up my mind
which way it was supposed to be.  Oh the joys of half-missing
documentation.
