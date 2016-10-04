From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 4 Oct 2016 08:50:15 +0200
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930193231.GA2521@remoulade>
 <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
 <20161001181101.GA17554@remoulade>
 <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
Message-ID: <20161004065015.GK3318@worktop.controleur.wifipass.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 03:20:57PM -0400, bdegraaf at codeaurora.org wrote:
> Thinking about this, as the reader/writer code has no known "abuse"
> case, I'll remove it from the patchset, then provide a v2 patchset
> with a detailed explanation for the lockref problem using the commits
> you provided as an example, as well as performance consideration.

Please, fix lockref in those patches. Touching the spinlock because
lockref does something dubious really is the wrong thing.
