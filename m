From: jcm@redhat.com (Jon Masters)
Date: Fri, 27 Feb 2015 07:42:30 -0500
Subject: [PATCH V4 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
Message-ID: <54F06636.6080905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2014 10:03 AM, Steve Capper wrote:

> This series implements general forms of get_user_pages_fast and
> __get_user_pages_fast in core code and activates them for arm and arm64.
> 
> These are required for Transparent HugePages to function correctly, as
> a futex on a THP tail will otherwise result in an infinite loop (due to
> the core implementation of __get_user_pages_fast always returning 0).
> 
> Unfortunately, a futex on THP tail can be quite common for certain
> workloads; thus THP is unreliable without a __get_user_pages_fast
> implementation.
> 
> This series may also be beneficial for direct-IO heavy workloads and
> certain KVM workloads.
> 
> I appreciate that the merge window is coming very soon, and am posting
> this revision on the off-chance that it gets the nod for 3.18. (The changes
> thus far have been minimal and the feedback I've got has been mainly
> positive).

Head's up: these patches are currently implicated in a rare-to-trigger
hang that we are seeing on an internal kernel. An extensive effort is
underway to confirm whether these are the cause. Will followup.

Jon.
