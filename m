From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 27 Aug 2014 14:42:41 -0700
Subject: [PATCH v9 0/6] ARM: VDSO
In-Reply-To: <53FE4448.9070708@codeaurora.org>
References: <1408744351-7814-1-git-send-email-nathan_lynch@mentor.com>
 <53FE4448.9070708@codeaurora.org>
Message-ID: <CALCETrULQ2y1z7FzXw7xHAk0Kv4M1_=0WBQvC219Mb9A6Tu=YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 1:49 PM, Christopher Covington
<cov@codeaurora.org> wrote:
> It appears to me that there is code in several architecture subdirectories
> (I'm aware of x86, arm64, and with these patches arm[32] and I would be
> surprised if there weren't more) doing largely the same setup of special
> mappings at randomized offsets, checking ELF magic etc. Not that these patches
> should necessarily do it, but is there a reasonable amount of consolidation
> that could be done, or am I underestimating how much of this really does vary
> per architecture?
>

There's certainly code that could be consolidated, but it would be a
decently large project.

Some day, I'd like to see everyone use vdso2c, but it needs to stop
knowing that it's targetting x86 for that to happen.

--Andy
