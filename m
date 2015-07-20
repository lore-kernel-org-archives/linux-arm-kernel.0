From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jul 2015 11:15:10 +0100
Subject: next-20150720 build: 1 failures 21 warnings (next-20150720)
In-Reply-To: <E1ZH5pS-0005rv-Dg@optimist>
References: <E1ZH5pS-0005rv-Dg@optimist>
Message-ID: <20150720101510.GB11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 08:49:38AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to some implicit
definitions introduced in 1ac0bfba883ee2bf (Coresight: Add an interface
for supporting ETM3/4 Context ID tracing) which introduces dependencies
on sched.h but doesn't add an include of that header leading to problems
if it's not implicitly included by something else:

> 	arm-allmodconfig
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
> ../include/linux/sched.h:1899:21: error: static declaration of 'task_pid_nr' follows non-static declaration
> ../include/linux/sched.h:2427:28: error: conflicting types for 'find_task_by_vpid'
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:259:2: error: implicit declaration of function 'find_task_by_vpid' [-Werror=implicit-function-declaration]
> ../include/linux/coresight.h:261:3: error: implicit declaration of function 'task_pid_nr' [-Werror=implicit-function-declaration]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/d6aabb0b/attachment.sig>
