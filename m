From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 17 Jan 2018 09:05:13 +0100
Subject: [PATCH] clk: Properly update prepare/enable count on orphan clock
 reparent
In-Reply-To: <20180115115214.10303-1-m.szyprowski@samsung.com>
References: <CGME20180115115231eucas1p1499f46ca64b65598d03a182ed5670f28@eucas1p1.samsung.com>
 <20180115115214.10303-1-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPdZupF7tsdQ7ZUON95ska3XFgTMgeD1359He_=8FyGy2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 12:52 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> If orphaned clock has been already prepared/enabled (for example if it or
> one of its children has CLK_IS_CRITICAL flag), then the prepare/enable
> counters of the newly assigned parent are not updated correctly. This
> might later cause warnings during changing clock parents.
>

Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
