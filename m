From: daniel@caiaq.de (Daniel Mack)
Date: Sun, 30 May 2010 09:36:52 +0200
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
Message-ID: <20100530073652.GX2695@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 29, 2010 at 06:02:28PM -0400, Bjoern Brandenburg wrote:
> We've tried three kernel versions:
> - 2.6.33-arm1 [1]
>   - boot log: http://pastebin.com/UqhfJNgz
> - 2.6.34-vanilla
>   - boot log with maxcpus=1: http://pastebin.com/NHHeYpbb
>   - boot log with failure: http://pastebin.com/uy6y8msZ
>   - config: http://pastebin.com/v9dttg0L
> - 2.6.34-arm  [2]
>   - boot log with maxcpus=1: http://pastebin.com/rCy2x9AP
>   - boot log with failure: http://pastebin.com/spam.php?i=mpedVqp3
> 
> Of these, only 2.6.33-arm1 boots with more than one CPU enabled. The 2.6.34
> versions only boot to login if we restrict the number of CPUs. The configuration
> used in all cases is based on the one provided by ARM [3]. For 2.6.34, we used
> 'make oldconfig' and accepted all defaults.

This sounds like a perfect case for giving 'git bisect' a try. It will
point you to the commit between 2.6.33 and 2.6.34 which broke it for
you.

See for example http://www.landley.net/writing/git-quick.html#bisect for
a detailed explanation of how to use it.


Daniel
