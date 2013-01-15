From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 15 Jan 2013 17:42:42 +0000
Subject: [RFC PATCH 0/4] b.L: Memory barriers and miscellaneous tidyups
In-Reply-To: <alpine.LFD.2.02.1301151228070.6300@xanadu.home>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
 <alpine.LFD.2.02.1301151228070.6300@xanadu.home>
Message-ID: <20130115174242.GA1983@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 12:29:22PM -0500, Nicolas Pitre wrote:
> On Tue, 15 Jan 2013, Dave Martin wrote:
> 
> > After much head-scratching and discussion, I have concluded that we
> > need comprehensive memory barriers in order to ensure that the
> > low-level synchronisation code executes robustly on all platforms.
> > 
> > DSBs are excessive on most situations though, so many DSBs can be
> > replces with DMBs.
> > 
> > As was observed in review, providing a C interface to the vlocks
> > makes little sense, so this series gets rid of it.
> 
> Thanks.  I have already removed the C stuff in my version but I'll merge 
> the rest no problem.

OK, I wasn't sure whether you'd already done that, but figured the patch
would be trivial to throw away (it's not like I invested a lot of time
in that one!)

I've done my best with the barriers, but if you have any concerns about
correctness, let me know.

Cheers
---Dave
