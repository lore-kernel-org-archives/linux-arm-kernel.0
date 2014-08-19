From: geoff@infradead.org (Geoff Levand)
Date: Tue, 19 Aug 2014 12:42:51 -0700
Subject: [PATCH v1] Arm64: Remove unnecessary keyword 'extern' from
 proc-fns.h
In-Reply-To: <1408438726-2413-1-git-send-email-achandran@mvista.com>
References: <1408438726-2413-1-git-send-email-achandran@mvista.com>
Message-ID: <1408477371.22761.145.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Tue, 2014-08-19 at 14:28 +0530, Arun Chandran wrote:
> As the functions have external linkage by default, the extern
> keyword is irrelevant here.

extern is used to say that the storage of a variable is done
somewhere else.  It marks a statement as a declaration when
there is ambiguity about if the statement is a definition or
declaration.  Since function prototypes are not definitions,
extern doesn't have any effect on them.  It is not really
related to linkage or scope.

-Geoff
