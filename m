From: jeffv@google.com (Jeffrey Vander Stoep)
Date: Wed, 28 Oct 2015 17:01:37 -0700
Subject: [PATCH 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <871tcewoso.fsf@x220.int.ebiederm.org>
References: <1446067520-31806-1-git-send-email-dcashman@android.com>
 <871tcewoso.fsf@x220.int.ebiederm.org>
Message-ID: <CABXk95DOSKv70p+=DQvHck5LCvRDc0WDORpoobSStWhrcrCiyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plain text this time...

> This all would be much cleaner if the arm architecture code were just to
> register the sysctl itself.
>
> As it sits this looks like a patchset that does not meaninfully bisect,
> and would result in code that is hard to trace and understand.

I believe the intent is to follow up with more architecture specific
patches to allow each architecture to define the number of bits to use
(min, max, and default) since these values are architecture dependent.
Arm64 patch should be forthcoming, and others after that. With that in
mind, would you still prefer to have the sysctl code in the
arm-specific patch?
