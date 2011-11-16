From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 11:54:35 +0000
Subject: Crash when memset of shared mapped memory in ARM
In-Reply-To: <20111116084547.GG9581@n2100.arm.linux.org.uk>
References: <CAJ8eaTzOtgMzcZeRr6f=+WhtsykK1NZraOGBPoqGncwcAGcTyQ@mail.gmail.com>
 <20111116084547.GG9581@n2100.arm.linux.org.uk>
Message-ID: <20111116115435.GI4942@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Replying to Russell so as to lose the -request addresses)

On Wed, Nov 16, 2011 at 08:45:47AM +0000, Russell King - ARM Linux wrote:
> Please do not spam mailing lists -request addresses when you post.  The
> -request addresses are there for you to give the mailing list software
> _instructions_ on what to do with your subscription.  It is not for
> posts to the mailing list.

For what it's worth, I was brave/daft enough to compile and run the testcase
with an -rc1 kernel and Linaro 11.09 filesystem on the quad A9 Versatile
Express:

root at dancing-fool:~# ./yad
mmap: addr 0x20000000
root at dancing-fool:~# ./yad
shm_open: File exists
mmap: addr 0x20000000

Looks like I'm missing the fireworks, despite the weirdy MAP_SHARED |
MAP_FIXED mmap flags.

Will
