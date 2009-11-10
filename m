From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Nov 2009 19:17:40 +0000
Subject: Runtime code modification fails on arm
In-Reply-To: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
References: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
Message-ID: <20091110191740.GA20317@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 02:08:27AM +1300, Papalagi Pakeha wrote:
> Why is this happening? What is so different between x86 and ARM in
> that field? I'm aware that my problem exhibits in userspace, not in
> the kernel. I'm sorry if it's way off topic here.

ARM CPUs tend to have a Harvard architecture:
  http://en.wikipedia.org/wiki/Harvard_architecture

See the paragraph just above "Uses" for the problem you are hitting
and the solution.  As others in this thread have pointed out, the
kernel provides a call to deal with the I/D cache coherency problem
which must be called _after_ _any_ modification of instructions
whether they have been executed previously or not.
