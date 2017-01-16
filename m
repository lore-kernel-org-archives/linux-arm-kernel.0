From: qiyaoltc@gmail.com (Yao Qi)
Date: Mon, 16 Jan 2017 12:27:55 +0000
Subject: [RFC PATCH 07/10] arm64/sve: Add vector length inheritance control
In-Reply-To: <1484220369-23970-8-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-8-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170116122755.GH28060@E107787-LIN>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-01-12 11:26:06, Dave Martin wrote:
> Currently the vector length is inherited across both fork() and
> exec().
> 
> Inheritance across fork() is desirable both for creating a copy of
> a process (traditional fork) or creating a thread (where we want
> all threads to share the same VL by default).
> 
> Inheritance across exec() is less desirable, because of the ABI
> impact of large vector lengths on the size of the signal frame --
> when running a new binary, there is no guarantee that the new
> binary is compatible with these ABI changes.
> 
> This flag makes the vector length non-inherited by default.

Can we make vector length inherited across fork but non-inherited
across exec by default?

> Instead, the vector length is reset to a system default value,
> unless the THREAD_VL_INHERIT flag has been set for the thread.
> 
> THREAD_VL_INHERIT is currently sticky: i.e., if set, it gets
> inherited too.  This behaviour may be refined in future if it is
> not flexible enough.
> 

-- 
Yao (??)
