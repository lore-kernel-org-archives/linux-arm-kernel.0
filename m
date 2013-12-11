From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 11 Dec 2013 16:43:01 +0100
Subject: regulator-core has_full_constraints set too late for dt using boards ?
Message-ID: <52A88805.1080704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

While looking into making regulator_get_optional not print
an error when no regulator is found, I've noticed that
for dt enabled boards, has_full_constraints is not set
until regulator_init_complete() runs, which is a
late_initcall.

This means that it gets set after it has already been checked
from calls like regulator_get which are likely done by init
functions running earlier.

This seems wrong ...

Regards,

Hans
