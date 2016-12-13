From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 13 Dec 2016 11:14:49 -0800
Subject: [PATCH] Input: imx6ul_tsc - generalize the averaging property
In-Reply-To: <20161213191050.3yrmxaubpgjh65bz@rob-hp-laptop>
References: <1481440003-27168-1-git-send-email-guy.shapiro@mobi-wize.com>
 <20161213191050.3yrmxaubpgjh65bz@rob-hp-laptop>
Message-ID: <1CDAF0C6-25E1-4CE9-8F98-F07333827B98@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On December 13, 2016 11:10:50 AM PST, Rob Herring <robh@kernel.org> wrote:
>On Sun, Dec 11, 2016 at 09:06:43AM +0200, Guy Shapiro wrote:
>> Make the avarage-samples property a general touchscreen property
>> rather than imx6ul device specific.
>> 
>> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
>> ---
>>  .../bindings/input/touchscreen/imx6ul_tsc.txt      | 11 ++----
>>  .../bindings/input/touchscreen/touchscreen.txt     |  3 ++
>>  drivers/input/touchscreen/imx6ul_tsc.c             | 46
>++++++++++++++++------
>>  3 files changed, 41 insertions(+), 19 deletions(-)
>
>You can't just switch existing bindings as that breaks compatibility 
>with old dtbs. The kernel driver would need to support both. Just 
>introduce the new common property and use it for your device.
>

The old binding is only in my tree at the moment, so I do not think there is compatibility concerns.

Are you OK with the new binding itself?


Thanks.

-- 
Dmitry
