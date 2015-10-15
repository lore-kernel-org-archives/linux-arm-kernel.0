From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 15 Oct 2015 10:18:12 -0400
Subject: [PATCH] arm64: ftrace: function_graph: dump real return addr in
 call trace
In-Reply-To: <20151015125133.GA29301@arm.com>
References: <1444911155-17480-1-git-send-email-huawei.libin@huawei.com>
 <6277407.jveniKQDxt@wuerfel> <20151015125133.GA29301@arm.com>
Message-ID: <20151015101812.7cb6e917@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Oct 2015 13:51:33 +0100
Will Deacon <will.deacon@arm.com> wrote:

> Is this the same old problem caused by e306dfd06fcb ("ARM64: unwind: Fix
> PC calculation")? I've said previously that I'm happy to revert that if
> we're the only architecture with this behaviour, but Akashi resisted
> because there are other issues with ftrace that he was hoping to address
> and they would resolve this too.

Just a reference, but this patch is pretty much exactly what x86
currently has. I wonder if I should make that function generic for all
archs to use.

If you accept this patch, I can look at what archs do and pull out the
common code and place it into the core code and have the archs call
that instead.

-- Steve
