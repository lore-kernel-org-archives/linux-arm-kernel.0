From: eugene.loh@oracle.com (Eugene Loh)
Date: Wed, 27 Jun 2018 12:02:23 -0700
Subject: [PATCH] arm64: entry: add END/ENDPROC markers to *.S files
In-Reply-To: <20180627130917.g45eigeevavqsi3u@lakrids.cambridge.arm.com>
References: <1530035261-17786-1-git-send-email-eugene.loh@oracle.com>
 <20180627130917.g45eigeevavqsi3u@lakrids.cambridge.arm.com>
Message-ID: <053d2679-2036-09b5-b9c0-68a1a13794d3@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to Mark and Will for pointing me to Mark's work, which makes this 
patch unneeded.

A few more comments below in case anyone is interested.

On 06/27/2018 06:09 AM, Mark Rutland wrote:

> On Tue, Jun 26, 2018 at 10:47:41AM -0700, eugene.loh at oracle.com wrote:
>> Add END/ENDPROC markers to *.S files so that assembly instructions
>> can be mapped to symbols.
> Is this just for external debug, or does anything in-kernel rely on this?

It was motivated by DTrace, which got symbolic information from "nm -S 
vmlinux".

> I'm converting the syscall paths to C [1], which should address all of the above...
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582238.html

Bingo.  Thanks.
