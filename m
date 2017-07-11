From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jul 2017 18:57:58 +0100
Subject: [PATCH] arm64: Decode information from ESR upon mem faults
In-Reply-To: <42862eff-5e90-31c7-46d7-0270d4ac8e08@arm.com>
References: <1497446043-50944-1-git-send-email-julien.thierry@arm.com>
 <20170619171305.GA12786@arm.com>
 <42862eff-5e90-31c7-46d7-0270d4ac8e08@arm.com>
Message-ID: <20170711175757.GG13977@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 09:58:12AM +0100, Julien Thierry wrote:
> As you mentioned, this is similar to the register dump and now that I look
> at it, registers are more grouped (2-3 per line). Maybe we could keep the
> debug info on multiple lines but grouping a bit more instead of having 1
> field per line:
> 
> [  122.109118] Mem abort info:
> [  122.111884]   Exception class = DABT (current EL), IL = 32 bits, SET = 0
> [  122.121507]   FnV = 0, EA = 0, S1PTW = 0
> [  122.128347] Data abort info:
> [  122.131212]   ISS[23:14] invalid
> [  122.134417]   CM = 0, WnR = 1
> 
> When ISS is not invalid, it's fields could be printed on the same line.

I'd rather keep the same print structure, regardless of whether or not the
ISS is known or not (and also why I'd like to print the hex value when it's
invalid).

> I think it would keep the code simple and the debug info readable. There
> would be less lines to interleave although that issue would not be
> completely solved.

Sounds good to me.

> Otherwise, maybe we could prefix the lines with a cpu id in order to be able
> to distinguish interleaved debug infos? But that could be done as well for
> the register dumps if this is necessary.

I wouldn't bother with the CPU number.

Will
