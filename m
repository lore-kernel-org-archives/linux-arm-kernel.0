From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Oct 2017 16:30:56 +0100
Subject: A issue about ptrace/SINGLESTEP on arm64
In-Reply-To: <8ad32f6b-e04d-98f8-d944-7ec3582fbdf4@huawei.com>
References: <8ad32f6b-e04d-98f8-d944-7ec3582fbdf4@huawei.com>
Message-ID: <20171016153055.GD10500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 12:27:17PM +0800, chengjian (D) wrote:
> Hi
> I write demo use ptrace/SINGLESTEP to count the number of instructions
> executed by the process
> The parent process fork+exec a child process, and trace(SINGLESTEP) it,
> 
> It works fine under the x86_64 architecture but has an exception under
> arm64.

My guess is that you are getting stuck in an LDXR/STXR loop, which cannot
be stepped. Can you jump the PC once the child appears to be "stuck"?

IIRC, GDB has special heuristics to step through LDXR/STXR critical
sections.

Will
