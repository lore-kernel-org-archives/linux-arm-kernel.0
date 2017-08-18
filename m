From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 18 Aug 2017 11:42:16 +0530
Subject: [PATCH v2 09/16] dmaengine: bcm-sba-raid: Improve
 sba_issue_pending() run duration
In-Reply-To: <20170817063614.GZ3053@localhost>
References: <1501583880-32072-1-git-send-email-anup.patel@broadcom.com>
 <1501583880-32072-10-git-send-email-anup.patel@broadcom.com>
 <20170817063614.GZ3053@localhost>
Message-ID: <CAALAos8+K4XL7GS7rzLrwO=LoFM0wfG1QdWvPX3ryED5spKVcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 12:06 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Aug 01, 2017 at 04:07:53PM +0530, Anup Patel wrote:
>> The pending sba_request list can become very long in real-life usage
>> (e.g. setting up RAID array) which can cause sba_issue_pending() to
>> run for long duration.
>
> that raises the warning flags.. Even if we have a long pending list why
> would issue_pending run for long. The purpose of the issue_pending() is to
> submit a txn if idle and return. The interrupt and tasklet shall push the
> subsequent txn to hardware...

Yes, we are doing very similar thing in PATCH13 by further
simplifying sba_process_deferred_requests()

Regards,
Anup
