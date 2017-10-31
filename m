From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 31 Oct 2017 09:44:20 -0700
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
Message-ID: <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 9:15 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
>
> On arm32, it is possible to set up udelay() to be clock-based.

I'm not sure why this is discussed as some kind of generic problem.

Just do what x86-64 already does. We use the TSC, and ndelay() does
the right thing too.

I've not checked precision, but it should be close to the TSC update
frequency. So we're talking tens of megahertz.

Does it work on all PC's? No. It's only half-way reliable on the ones
where the TSC frequency doesn't change. So there are no *guarantees*.

               Linus
