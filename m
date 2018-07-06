From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Fri, 6 Jul 2018 13:30:04 -0400 (EDT)
Subject: arm32: Missing __get_user for u64 user type
Message-ID: <208280844.1302.1530898204811.JavaMail.zimbra@efficios.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The restartable sequence code needs a __get_user for u64 types.
arm32. Although a get_user() is implemented, the architecture
lacks support for 8 bytes __get_user().

Do you guys recommend extending __get_user_err() to do two
__get_user_asm_word() to read it through a temporary union,
or do you have other approaches in mind ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
