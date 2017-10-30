From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 30 Oct 2017 15:51:49 -0600
Subject: [PATCH 0/2] Fix s5p-mfc lock contention in request firmware paths
In-Reply-To: <CAM3PiRzS966v=pWRq641sFF-Kg5wHc6fH524CQKusURNfcD0ew@mail.gmail.com>
References: <cover.1507325072.git.shuahkh@osg.samsung.com>
 <354e3c31-e502-5ba6-d705-9d67764e78bf@osg.samsung.com>
 <CAM3PiRzS966v=pWRq641sFF-Kg5wHc6fH524CQKusURNfcD0ew@mail.gmail.com>
Message-ID: <b61035e1-cf27-2949-4c3f-1e5755e44670@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2017 04:28 PM, Marian Mihailescu wrote:
> Hi Shuah,
> 
> For MFC patch, you can delete the "dev" variable since it's not being
> used anymore and results in a compile warning.
> 
> - struct s5p_mfc_dev *dev = ctx->dev;
> 

Hi Marian,

This series doesn't have the unused warn problem. I fixed the problem
in media: s5p-mfc: fix lockdep warning patch that has the warning and
sent v2.


> On Thu, Oct 26, 2017 at 7:54 AM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>> On 10/06/2017 03:30 PM, Shuah Khan wrote:
>>> This patch series fixes inefficiencies and lock contention in the request
>>> firmware paths.
>>>
>>> Shuah Khan (2):
>>>   media: s5p-mfc: check for firmware allocation before requesting
>>>     firmware
>>>   media: s5p-mfc: fix lock confection - request_firmware() once and keep
>>>     state
>>>
>>>  drivers/media/platform/s5p-mfc/s5p_mfc.c        |  4 ++++
>>>  drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  3 +++
>>>  drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c   | 15 ++++++++++-----
>>>  3 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>
>> Any feedback on this series?
>>

Still waiting for feedback on this series.

thanks,
-- Shuah
