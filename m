From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 22 Sep 2015 16:54:41 +0900
Subject: [PATCH resend] extcon: Fix attached value returned by
 is_extcon_changed
In-Reply-To: <5600FF6A.7060305@redhat.com>
References: <1442752494-22244-1-git-send-email-hdegoede@redhat.com>
 <1442752494-22244-2-git-send-email-hdegoede@redhat.com>
 <55FF5F2F.9010504@samsung.com> <55FFEA1F.7050500@redhat.com>
 <5600B290.9090502@samsung.com> <5600FF6A.7060305@redhat.com>
Message-ID: <56010941.2040704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 09? 22? 16:12, Hans de Goede wrote:
> Hi,
> 
> On 22-09-15 03:44, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2015? 09? 21? 20:29, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 21-09-15 03:36, Chanwoo Choi wrote:
>>>> On 2015? 09? 20? 21:34, Hans de Goede wrote:
>>>>> is_extcon_changed should only check the idx-th bit of new, not
>>>>> the entirety of new when setting attached.
>>>>>
>>>>> This fixes extcon sending notifications that a cable was inserted when
>>>>> it gets removed while another cable is still connected.
>>>>>
>>>>> Cc: stable at vger.kernel.org
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>    drivers/extcon/extcon.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>>>>> index a07addd..8dd0af1 100644
>>>>> --- a/drivers/extcon/extcon.c
>>>>> +++ b/drivers/extcon/extcon.c
>>>>> @@ -159,7 +159,7 @@ static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
>>>>>    static bool is_extcon_changed(u32 prev, u32 new, int idx, bool *attached)
>>>>>    {
>>>>>        if (((prev >> idx) & 0x1) != ((new >> idx) & 0x1)) {
>>>>> -        *attached = new ? true : false;
>>>>> +        *attached = ((new >> idx) & 0x1) ? true : false;
>>>>>            return true;
>>>>>        }
>>>>>
>>>>>
>>>>
>>>> This patch was already applied[1].
>>>> [1] https://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next
>>>
>>> Yet it is not in 4.3-rc1, applying the patch to your tree is not useful
>>> unless you also send a pull-req to get the changes in your tree actually
>>> merged ...
>>
>> No. It is useful step. It is first step to send pull-request for including the main tree.
>> I'll send pull-request before releasing official version.
> 
> This patch fixes a bug in the extcon core, thus affecting ALL extcon users, the patch

I know.

> is trivial, so IMHO this patch should have been part of a pull-req already, adn should

I'll send pull-request to include this patch on rc release. But it is not fixed that
should be included in rc1. Don't worry about this patch that is included in rcX version.

> be Cc: stable at vger.kernel.org. When you do you plan to submit a pullreq with this
> patch ?

I'll send fixes pull-request wihtin this week for including it in rc3.

Thanks,
Chanwoo Choi
